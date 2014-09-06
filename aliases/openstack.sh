tenant_id() {
    keystone token-get | grep tenant | awk '{print $4}'
}

