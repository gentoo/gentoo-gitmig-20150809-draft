service glftpd
{
    disable         = yes
    flags           = REUSE NAMEINARGS
    socket_type     = stream
    protocol        = tcp
    wait            = no
    user            = root
    server          = /usr/sbin/tcpd
    server_args     = /opt/glftpd/bin/glftpd -l -i -o -r /opt/glftpd/glftpd.conf -s/opt/glftpd/bin/glstrings.bin 
    only_from       = 0.0.0.0
}
