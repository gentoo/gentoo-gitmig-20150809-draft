DESCRIPTION="hp Server Management Drivers and Agents."
HOMEPAGE="http://h18000.www1.hp.com/products/servers/linux/documentation.html"
LICENSE="hp-value"
RDEPEND="snmp? ( net-analyzer/net-snmp )"

DEPEND="${RDEPEND}
	virtual/linux-sources
	mailx
	rpm2targz"

SRC_URI="ftp://ftp.compaq.com/pub/products/servers/supportsoftware/linux/RedHat/hpasm-6.30.0-12.Redhat8_0.i386.rpm"

IUSE=""
SLOT="0"
KEYWORDS="~x86"
S="${WORKDIR}"


src_unpack() {
	cd ${S}
	rpm2targz ${DISTDIR}/hpasm-6.30.0-12.Redhat8_0.i386.rpm
	tar zxf ${S}/hpasm-6.30.0-12.Redhat8_0.i386.tar.gz 
	rm ${S}/opt/compaq/hpasm/addon/libcpqci.so
	rm ${S}/opt/compaq/hpasm/addon/libcpqci.so.1
}

src_install() {

	

	HPASM_HOME="/opt/compaq"
	
	dodir ${HPASM_HOME}

    cp -Rdp \
        opt/compaq/* \
		${D}${HPASM_HOME}

	into /
	dosbin sbin/bootcfg 

	dosym /opt/compaq/hpasm/addon/libcpqci.so.1.0 /opt/compaq/hpasm/addon/libcpqci.so.1
	dosym /opt/compaq/hpasm/addon/libcpqci.so.1.0 /opt/compaq/hpasm/addon/libcpqci.so

	dodir /usr/share/pixmaps
	dosym /opt/compaq/cpqhealth/cpqasm/hplogo.xbm /usr/share/pixmaps/hplogo.xbm
	dosym /opt/compaq/cpqhealth/cpqasm/m_blue.gif /usr/share/pixmaps/m_blue.gif
	dosym /opt/compaq/cpqhealth/cpqasm/m_fail.gif /usr/share/pixmaps/m_fail.gif
	dosym /opt/compaq/cpqhealth/cpqasm/m_green.gif /usr/share/pixmaps/m_green.gif
	dosym /opt/compaq/cpqhealth/cpqasm/m_red.gif /usr/share/pixmaps/m_red.gif
	dosym /opt/compaq/cpqhealth/cpqasm/m_yellow.gif /usr/share/pixmaps/m_yellow.gif

	dosym /opt/compaq/cpqhealth/cpqasm/cpqimlview /sbin/cpqimlview
	dosym /opt/compaq/cpqhealth/cpqasm/cpqimlview /sbin/hpimlview
	dosym /opt/compaq/cpqhealth/cpqasm/cpqimlview.tcl /sbin/cpqimlview.tcl
	dosym /opt/compaq/cpqhealth/hplog /sbin/hplog
	dosym /opt/compaq/cpqhealth/hpuid /sbin/hpuid
	dosym /opt/compaq/cpqhealth/cpqasm/imlbe /sbin/imlbe

	dosym /opt/compaq/hpasm/etc/rebuild /sbin/hpasm_rebuild

	dodir /usr/lib

	if [ ! -f /usr/lib/libcrypto.so.2 ]
    		then
		dosym /usr/lib/libcrypto.so.0.9.6 /usr/lib/libcrypto.so.2
	fi

	if [ ! -f /usr/lib/libssl.so.2 ]
    		then
		dosym /usr/lib/libssl.so.0.9.6 /usr/lib/libssl.so.2
	fi

	dodir /var/spool/compaq


	exeinto /etc/init.d
	doexe etc/init.d/hpasm

	doman usr/share/man/man4/cpqhealth.4.gz usr/share/man/man4/hpasm.4.gz \
		usr/share/man/man8/cpqimlview.8.gz usr/share/man/man8/hplog.8.gz \
		usr/share/man/man8/hpuid.8.gz
	
}
	
pkg_postinst() {
	einfo ""
	einfo "If you want to run cpqimlview or hpimlview you will" 
	einfo "need to emerge xfree, tix, and tclx"
	einfo ""
	einfo "You now need to execute /etc/init.d/hpasm start in"
	einfo "order to use the installed package. The kernel"
	einfo "modules will automatically build for you."
	einfo ""
}



