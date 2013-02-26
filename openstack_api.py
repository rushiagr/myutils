#!/usr/bin/python

import httplib
import json

class API(object):
    """API object to connect to an OpenStack environment."""
    
    def __init__(self, osurl=None, osuser=None, ospassword=None):
        self.url = osurl or "10.63.165.22"
        self.osuser = osuser or "demo"
        self.ospassword = ospassword or "nova"
        
        self.tenant_id = None
        self.default_header = {"Content-Type": "application/json"}
        
        self.keystone_host = self.url + ":5000"
        self.cinder_host = self.url + ":8776"
        self.tenant_id = self.get_tenant_id_for_user()
        self.token = self.get_token()

    def send_request(self, request_type, host, url, params=None, headers=None):
        """
        Sends the request with provided parameters and returns back the
        data returned from the request (if any).
        """
        if isinstance(params, dict):
            params = json.dumps(params)
        conn = httplib.HTTPConnection(host)
        conn.set_debuglevel(1)
        conn.request(request_type, url, params, headers or self.default_header)

        if request_type == "DELETE":
            return

        response = conn.getresponse()
        data = response.read()
        datadict = json.loads(data)
        conn.close()
        return datadict
        

    def get_post_data(self, host, url, params, headers=None):
        """
        Get data for a POST request.
        
        :param host: e.g. '10.10.0.110:5000'
        :param url: e.g. '/v1/tokens'
        :param params: Stringified parameter dict
        :param headers: Headers dict, e.g. {"X-Auth-Token":"blah"}
        """
        if isinstance(params, dict):
            params = json.dumps(params)
        conn = httplib.HTTPConnection(host)
        conn.set_debuglevel(1)
        conn.request("POST", url, params, headers or self.default_header)
        response = conn.getresponse()
        data = response.read()
        datadict = json.loads(data)
        conn.close()
        return datadict

    def get_get_data(self, host, url, headers=None):
        """
        Get data for a GET request.
        
        :param host: e.g. '10.10.0.110:5000'
        :param url: e.g. '/v1/tokens'
        :param headers: Headers dict, e.g. {"X-Auth-Token":"blah"}
        """
        conn = httplib.HTTPConnection(host)
        conn.set_debuglevel(1)
        print 'get called. headers: ', headers or self.default_header
        conn.request("GET", url, None, headers or self.default_header)
        response = conn.getresponse()
        data = response.read()
        print 'data', data
        datadict = json.loads(data)
        conn.close()
        return datadict


    def get_tenant_id_for_user(self, user=None, password=None):
        """
        The method first queries keystone and gets a small token to get the
        tenant ID, and then uses this tenant ID to generate a full PKI token.
        """
        # Get token to query tenant ID
        param_dict = {
            "auth": {
                "passwordCredentials": {
                    "username": user or self.osuser,
                    "password": user or self.ospassword
                }
            }
        }
        params = json.dumps(param_dict)
        datadict = self.get_post_data(self.keystone_host,
                                      "/v2.0/tokens",
                                      params,
                                      self.default_header)
        tenant_id_token = datadict['access']['token']['id']
        
        # Now get the tenant ID
        header = {"X-Auth-Token": tenant_id_token}
        datadict = self.get_get_data(self.keystone_host,
                                        "/v2.0/tenants",
                                        header)
        for tenant_dict in datadict['tenants']:
            if tenant_dict['name'] == (user or self.osuser):
                print 'tenant_name:', tenant_dict['name'], 'tenant_id', tenant_dict['id']
                return str(tenant_dict['id'])
        raise

    def get_token(self):
        """
        Returns the token for the given {osuser,ospassword,tenant_id} tuple.
        """
        auth_string = {
            "auth" : {
                "passwordCredentials": {
                    "username": self.osuser,
                    "password": self.ospassword
                },
                    "tenantId": self.tenant_id
            }
        }
        params = json.dumps(auth_string)
        headers = {"Content-Type": "application/json"}
        
        conn = httplib.HTTPConnection(self.keystone_host)
        conn.request("POST", "/v2.0/tokens", params, headers)
        # HTTP response
        response = conn.getresponse()
        data = response.read()
        datadict = json.loads(data)
        conn.close()

        token = datadict['access']['token']['id']
        return str(token)

    def cinder_create(self, size):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        params = {"volume": {"size": size}}
        data = self.get_post_data(self.cinder_host,
                                  '/v1/%s/volumes' % self.tenant_id,
                                  params,
                                  headers)
        return data
    
    def cinder_list(self):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.get_get_data(self.cinder_host,
                                 '/v1/%s/volumes' % self.tenant_id,
                                 headers)
        return data
    
    def cinder_delete(self, vol_id):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.send_request("DELETE",
                                      self.cinder_host,
                                      '/v1/%s/volumes/%s' % (self.tenant_id,
                                                             vol_id))
        return data
    
    def cinder_delete_all(self):
        
        

if __name__ == '__main__':
    a = API()