S=${WORKDIR}/pptp-linux-${PV}-1
DESCRIPTION="Linux client for the proprietary Microsoft Point-to-Point Tunneling Protocol, PPTP. Allows connection to a PPTP based VPN 
as used by employers and some cable and ADSL service providers."

HOMEPAGE="http://pptpclient.sourceforge.net"
SRC_URI="mirror://sourceforge/pptpclient/pptp-linux-${PV}-1.tar.gz"

DEPEND="net-dialup/ppp"

RDEPEND="net-dialup/ppp"

src_compile() {
	cd ${S}
	tar zxf pptp-linux-${PV}.tar.gz
	cd ${S}/pptp-linux-${PV}

	make || die "make failed" 
}

src_install() {
	cd ${S}
	insinto /etc/ppp
	doins options.pptp
	dosbin pptp-command pptp_fe.pl xpptp_fe.pl	
	
	cd pptp-linux-${PV}
	dosbin pptp
	
	dodoc AUTHORS COPYING ChangeLog DEVELOPERS NEWS README TODO USING
	dodoc Documentation/*
	dodoc Reference/*
}

