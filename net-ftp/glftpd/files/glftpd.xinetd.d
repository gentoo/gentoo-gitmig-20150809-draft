service glftpd
{
    disable         = yes
    flags           = REUSE NAMEINARGS
    socket_type     = stream
    protocol        = tcp
    wait            = no
    user            = root
    server          = /usr/sbin/tcpd
    server_args     = GLROOT/bin/glftpd -l -i -o -r GLROOT/glftpd.conf -sGLROOT/bin/glstrings.bin
    only_from       = 0.0.0.0
}
