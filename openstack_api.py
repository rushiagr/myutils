#!/usr/bin/python

import httplib
import json

class API(object):
    """API object to connect to an OpenStack environment."""
    
    def __init__(self, osurl=None, osuser=None, ospassword=None):
        self.url = osurl or "10.63.165.20"
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

    # All the cinder volume functions

    def cinder_create(self, size):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        params = {"volume": {"size": size}}
        data = self.get_post_data(self.cinder_host,
                                  '/v1/%s/volumes' % self.tenant_id,
                                  params,
                                  headers)
        return data
    
#    def cinder_share_create(self, size, proto):
#        headers = self.default_header
#        headers["X-Auth-Token"] = self.token
#        params = {"share": {"size": size,
#                            "share_type": proto}}
#        data = self.get_post_data(self.cinder_host,
#                                  '/v1/%s/shares' % self.tenant_id,
#                                  params,
#                                  headers)
#        return data
    
    def cinder_list(self):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.get_get_data(self.cinder_host,
                                 '/v1/%s/volumes' % self.tenant_id,
                                 headers)
        return data
    
    def cinder_list_detail(self):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.get_get_data(self.cinder_host,
                                 '/v1/%s/volumes/detail' % self.tenant_id,
                                 headers)
        return data
    
    def cinder_list_v2(self):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.get_get_data(self.cinder_host,
                                 '/v2/%s/volumes' % self.tenant_id,
                                 headers)
        return data
    
    def cinder_list_detail_v2(self):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.get_get_data(self.cinder_host,
                                 '/v2/%s/volumes/detail' % self.tenant_id,
                                 headers)
        return data
    
    def cinder_snapshot_list(self):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.get_get_data(self.cinder_host,
                                 '/v2/%s/snapshots' % self.tenant_id,
                                 headers)
        return data
    
#    def cinder_share_list(self):
#        headers = self.default_header
#        headers["X-Auth-Token"] = self.token
#        data = self.get_get_data(self.cinder_host,
#                                 '/v1/%s/shares' % self.tenant_id,
#                                 headers)
#        return data
    
    def cinder_delete(self, vol_id):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.send_request("DELETE",
                                      self.cinder_host,
                                      '/v1/%s/volumes/%s' % (self.tenant_id,
                                                             vol_id))
        return data
    
    def cinder_delete_all(self):
        """
        Deletes all the volumes present in Cinder. As of this version,
        it tries to delete the volumes which are not in 'available' and
        'error' states too.
        """
        list_data = self.cinder_list()
        volumes = list_data['volumes']
        volume_ids = []
        for volume in volumes:
            volume_ids.append(str(volume['id']))
        for volume_id in volume_ids:
            self.cinder_delete(volume_id)
        print "successfully deleted all volumes"
        return
    
    def cinder_create_many(self, vol_number, vol_sizes=[1]):
        """
        Creates volumes equal to :vol_number: with sizes as per list
        :vol_sizes:. If there are more volumes than elements in list
        :vol_sizes:, a default value of 1GB will be used.
        """
        if vol_number > len(vol_sizes):
            vol_sizes.extend([1]*(vol_number-len(vol_sizes)))
        for vol_index in range(vol_number):
            self.cinder_create(vol_sizes[vol_index])

    # All the cinder SHARE functions

    def cinder_share_create(self, size, proto):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        params = {"share": {"size": size,
                            "share_type": proto}}
        data = self.get_post_data(self.cinder_host,
                                  '/v1/%s/shares' % self.tenant_id,
                                  params,
                                  headers)
        return data
    
    def cinder_share_allow(self, share_id, access_type, access_to):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        params = {"os-allow_access": {"access_type": access_type,
                                      "access_to": access_to}}
        data = self.get_post_data(self.cinder_host,
                                  '/v1/%s/shares/%s/action' % (self.tenant_id,share_id),
                                  params,
                                  headers)
        return data
        
    def cinder_share_deny(self, share_id, access_id):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        params = {"os-deny_access": {"access_id": access_id}}
        data = self.get_post_data(self.cinder_host,
                                  '/v1/%s/shares/%s/action' % (self.tenant_id,share_id),
                                  params,
                                  headers)
        return data

    def cinder_share_access_list(self, share_id):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        params = {"os-access_list": None}
        data = self.get_post_data(self.cinder_host,
                                  '/v1/%s/shares/%s/action' % (self.tenant_id,share_id),
                                  params,
                                  headers)
        return data
        
    
    #TODO(rushiagr): merge this def into the above one
    def cinder_share_create_from_snapshot(self, size, proto, snap_id):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        params = {"share": {"size": size,
                            "share_type": proto,
                            "share_id": snap_id}}
        data = self.get_post_data(self.cinder_host,
                                  '/v1/%s/shares' % self.tenant_id,
                                  params,
                                  headers)
        return data
    
    def cinder_share_list(self):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.get_get_data(self.cinder_host,
                                 '/v1/%s/shares' % self.tenant_id,
                                 headers)
        return data
    
    def cinder_share_snapshot_list(self):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.get_get_data(self.cinder_host,
                                 '/v1/%s/share-snapshots' % self.tenant_id,
                                 headers)
        return data
    
    def cinder_share_show(self, share_id):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.get_get_data(self.cinder_host,
                                 '/v1/%s/shares/%s' % (self.tenant_id, share_id),
                                 headers)
        return data
    
    def cinder_share_list_detail(self):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.get_get_data(self.cinder_host,
                                 '/v1/%s/shares/detail' % self.tenant_id,
                                 headers)
        return data
    
    def cinder_share_delete(self, vol_id):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        data = self.send_request("DELETE",
                                      self.cinder_host,
                                      '/v1/%s/shares/%s' % (self.tenant_id,
                                                             vol_id))
        return data
    
    def cinder_share_snapshot_create(self, shr_id):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        params = {"share-snapshot": {"share_id": shr_id,
                               #"display_name": "timepass_name"
                               }}
        data = self.get_post_data(self.cinder_host,
                                  '/v1/%s/share-snapshots' % self.tenant_id,
                                  params,
                                  headers)
        return data
        
    def cinder_share_snapshot_delete(self, shr_id):
        headers = self.default_header
        headers["X-Auth-Token"] = self.token
        params = {"share-snapshot": {"share_id": shr_id,
                               #"display_name": "timepass_name"
                               }}
        data = self.get_post_data(self.cinder_host,
                                  '/v1/%s/share-snapshots' % self.tenant_id,
                                  params,
                                  headers)
        return data
        
    
    def cinder_share_delete_all(self):
        """
        Deletes all the volumes present in Cinder. As of this version,
        it tries to delete the volumes which are not in 'available' and
        'error' states too.
        """
        list_data = self.cinder_share_list()
        shares = list_data['shares']
        share_ids = []
        for share in shares:
            share_ids.append(str(share['id']))
        for share_id in share_ids:
            self.cinder_share_delete(share_id)
        print "successfully deleted all volumes"
        return
    
    def cinder_share_create_many(self, vol_number, vol_sizes=[1]):
        """
        Creates volumes equal to :vol_number: with sizes as per list
        :vol_sizes:. If there are more volumes than elements in list
        :vol_sizes:, a default value of 1GB will be used.
        """
        if vol_number > len(vol_sizes):
            vol_sizes.extend([1]*(vol_number-len(vol_sizes)))
        for vol_index in range(vol_number):
            self.cinder_create(vol_sizes[vol_index])

if __name__ == '__main__':
    a = API()