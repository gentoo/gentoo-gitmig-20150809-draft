# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2


IUSE="crypt ipv6 activefilter"
S=${WORKDIR}/${P}.pppoe4
DESCRIPTION="Point-to-point protocol - patched for pppoe"
SRC_URI="mirror://gentoo/${P}-pppoe4.tgz"
HOMEPAGE="http://www.samba.org/ppp"

DEPEND="virtual/glibc
	activefilter? ( net-libs/libpcap )"

PROVIDE="virtual/pppd"

SLOT="0"
LICENSE="BSD GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~hppa"

src_compile() {

    use crypt && {
		#I took the liberty of combining the two crypto patches
		einfo "Applying ppp-crypto-fix.patch..."
		bzcat ${FILESDIR}/ppp-crypto-fix.patch.bz2 | patch -p1

	}

	epatch ${FILESDIR}/${P}-r10.patch

	use activefilter && {
    		# enable option active-filter
    		mv pppd/Makefile.linux pppd/Makefile.linux.orig
    		sed -e 's/^#FILTER=y/FILTER=y/' <pppd/Makefile.linux.orig >pppd/Makefile.linux
	}

	./configure --prefix=/usr || die
    
	#fix Makefiles to compile optimized
	cd ${S}/pppd
	mv Makefile Makefile.orig
	if([ `use ipv6` ]) then
		sed -e "s:COPTS = -O2 -pipe -Wall -g:COPTS = ${CFLAGS}:" \
			-e "s/LIBS =/LIBS = -lcrypt/" \
			-e "s/#HAVE_INET6/HAVE_INET6/" \
			-e "s/# CBCP_SUPPORT/CBCP_SUPPORT/" Makefile.orig > Makefile
	else
		sed -e "s:COPTS = -O2 -pipe -Wall -g:COPTS = ${CFLAGS}:" \
			-e "s/LIBS =/LIBS = -lcrypt/" \
			-e "s/# CBCP_SUPPORT/CBCP_SUPPORT/" Makefile.orig > Makefile
	fi

	cd plugins
	mv Makefile Makefile.orig
	sed -e "s:CFLAGS\t= -g -O2:CFLAGS = ${CFLAGS}:" \
		Makefile.orig > Makefile
	cd pppoe
	mv Makefile Makefile.orig
	sed -e "s:CFLAGS\t= -g :CFLAGS = ${CFLAGS}:" \
		Makefile.orig > Makefile
	cd ${S}/pppstats
	mv Makefile Makefile.orig
	sed -e "s:COPTS= -O:COPTS = ${CFLAGS}:" \
		Makefile.orig > Makefile
	cd ${S}/chat
	mv Makefile Makefile.orig
	sed -e "s:-O2:${CFLAGS}:" Makefile.orig > Makefile
	cd ${S}/pppdump
	mv Makefile Makefile.orig
	sed -e "s:CFLAGS= -O:CFLAGS= ${CFLAGS}:" Makefile.orig > Makefile
	cd ..
    
	export CC=gcc
    
	emake || die
}

src_install() {
	for y in chat pppd pppdump pppstats
	do
		doman ${y}/${y}.8
		dosbin ${y}/${y}
	done
    
	chmod u+s-w ${D}/usr/sbin/pppd
	dodir /etc/ppp/peers
	insinto /etc/ppp
	insopts -m0600
	doins etc.ppp/pap-secrets etc.ppp/chap-secrets
	insopts -m0644
	doins etc.ppp/options
	doins ${FILESDIR}/chat-default
	insopts -m0755
	doins ${FILESDIR}/ip-up
	doins ${FILESDIR}/ip-down
	exeinto /etc/init.d/
	doexe ${FILESDIR}/net.ppp0
	insinto /etc/conf.d
	insopts -m0600
	newins ${FILESDIR}/confd.ppp0 net.ppp0

	dolib.so pppd/plugins/minconn.so
	dolib.so pppd/plugins/passprompt.so
	dolib.so pppd/plugins/pppoe/pppoe.so
	newlib.so ${FILESDIR}/pppoatm.so pppoatm.so
	dodir /usr/lib/pppd/$(awk -F '"' '/VERSION/ {print $2}' pppd/patchlevel.h)
	mv ${D}/usr/lib/*.so ${D}/usr/lib/pppd/$(awk -F '"' '/VERSION/ {print $2}' pppd/patchlevel.h)
	insinto /etc/modules.d
	insopts -m0644
	newins ${FILESDIR}/modules.ppp ppp

	dodoc PLUGINS README* SETUP Changes-2.3 FAQ
	dohtml ${FILESDIR}/pppoe.html

# This has nothing to do with net.ppp0 now as net.ppp0 calls pppd
# from the command line with the parameters.	
	#New scripts acquired from cvs (cvs.samba.org)
	#Changed $PATH back
	dosbin ${FILESDIR}/pon
	dosbin ${FILESDIR}/poff
	dosbin ${FILESDIR}/plog
	doman ${FILESDIR}/pon.1

	#Adding misc. specialized scripts to doc dir
	dodir /usr/share/doc/${PF}/scripts
 	dodir /usr/share/doc/${PF}/scripts/chatchat
	insinto	/usr/share/doc/${PF}/scripts/chatchat
	doins scripts/chatchat/*
	insinto /usr/share/doc/${PF}/scripts
	doins scripts/*
}


pkg_postinst() {
	if [ ! -e ${ROOT}dev/.devfsd ]
	then
		if [ ! -e ${ROOT}dev/ppp ]; then
			mknod ${ROOT}dev/ppp c 108 0
		fi
	fi
	if [ "$ROOT" = "/" ]
	then
		/sbin/update-modules
	fi
	ewarn "To enable kernel-pppoe read html/pppoe.html in the doc-directory."
	ewarn "Pon, poff and plog scripts have been supplied for experienced users."
	ewarn "New users or those requiring something more should have a look at"
	ewarn "the /etc/init.d/net.ppp0 script."
	ewarn "Users needing particular scripts (ssh,rsh,etc.)should check out the"
	ewarn "/usr/share/doc/ppp*/scripts directory." 
}	

pkg_preinst() {
	# Fix those broken flags (755 -> 644)
	# This is needed for updates from ppp-2.4.1-r11 to ppp-2.4.1-r12
	if [ -e ${ROOT}/etc/modules.d/ppp ] ; then
		FLAGS="`stat -c %a /etc/modules.d/ppp`"
		echo ${FLAGS}
		if [ ${FLAGS} == "755" ] ; then
			chmod 644 ${ROOT}/etc/modules.d/ppp
		fi
	fi
}
