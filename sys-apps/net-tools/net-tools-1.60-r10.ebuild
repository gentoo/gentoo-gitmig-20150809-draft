# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/net-tools/net-tools-1.60-r10.ebuild,v 1.2 2005/01/10 18:30:53 vapier Exp $

inherit flag-o-matic toolchain-funcs eutils

DESCRIPTION="Standard Linux networking tools"
HOMEPAGE="http://sites.inka.de/lina/linux/NetTools/"
SRC_URI="http://www.tazenda.demon.co.uk/phil/net-tools/${P}.tar.bz2
	mirror://gentoo/${P}-gentoo-extra-1.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls build static uclibc"

RDEPEND=""
DEPEND="nls? ( sys-devel/gettext )
	>=sys-apps/sed-4"

src_unpack() {
	PATCHDIR=${WORKDIR}/${P}-gentoo

	unpack ${A}
	cd ${S}

	# Compile fix for 2.6 kernels
	epatch ${FILESDIR}/net-tools-1.60-2.6-compilefix.patch
	epatch ${FILESDIR}/${PV}-gcc34.patch #48167
	epatch ${FILESDIR}/net-tools-1.60-cleanup-list-handling.patch

	# Stack smashing attack in if_readlist_proc() from ifconfig - bug #58633
	epatch ${FILESDIR}/net-tools-1.60-get_name.patch

	# some redhat patches
	epatch ${PATCHDIR}/net-tools-1.54-ipvs.patch
	epatch ${PATCHDIR}/net-tools-1.57-bug22040.patch
	epatch ${PATCHDIR}/net-tools-1.60-manydevs.patch
	epatch ${PATCHDIR}/net-tools-1.60-miiioctl.patch
	epatch ${PATCHDIR}/net-tools-1.60-virtualname.patch
	epatch ${PATCHDIR}/net-tools-1.60-cycle.patch

	# GCC-3.3 Compile Fix
	epatch ${PATCHDIR}/${P}-multiline-string.patch

	# Misc patches, see headers of patches for more info
	epatch ${FILESDIR}/${PV}-man.patch #29677
	epatch ${FILESDIR}/${PV}-numeric-ports.patch #76756
	epatch ${FILESDIR}/${PV}-appletalk.patch #debian
	epatch ${FILESDIR}/${PV}-wide.patch #53731

	cp ${PATCHDIR}/net-tools-1.60-config.h config.h
	cp ${PATCHDIR}/net-tools-1.60-config.make config.make

	if use static ; then
		append-flags -static
		append-ldflags -static
	fi

	epatch "${FILESDIR}"/${PV}-Makefile.patch
	sed -i \
		-e "/^COPTS =/s:=:=${CFLAGS}:" \
		-e "/^LOPTS =/s:=:=${LDFLAGS}:" \
		Makefile || die "sed FLAGS Makefile failed"
	sed -i \
		-e "s:/usr/man:/usr/share/man:" \
		man/Makefile || die "sed man/Makefile failed"

	if ! use uclibc ; then
		cp -f ${PATCHDIR}/ether-wake.c ${S}
		cp -f ${PATCHDIR}/ether-wake.8 ${S}/man/en_US
	fi

	if ! use nls ; then
		sed -i -e 's:\(#define I18N\) 1:\1 0:' config.h \
			|| die "sed config.h failed"
		sed -i -e 's:I18N=1:I18N=0:' config.make \
			|| die "sed config.make failed"
	fi
}

src_compile() {
	tc-export CC
	emake libdir || die "emake libdir failed"
	emake || die "emake failed"

	if use nls ; then
		emake i18ndir || die "emake i18ndir failed"
	fi

	if ! use uclibc ; then
		$(tc-getCC) ${CFLAGS} -o ether-wake ether-wake.c || die "ether-wake failed to build"
	fi
}

src_install() {
	make BASEDIR="${D}" install || die "make install failed"

	if ! use uclibc ; then
		dosbin ether-wake || die "dosbin failed"
	fi
	mv ${D}/bin/* ${D}/sbin || die "mv failed"
	mv ${D}/sbin/{hostname,domainname,netstat,dnsdomainname,ypdomainname,nisdomainname} ${D}/bin \
		|| die "mv failed"
	use uclibc && rm -f ${D}/bin/{yp,nis}domainname
	dodir /usr/bin
	dosym /bin/hostname /usr/bin/hostname

	if ! use build
	then
		dodoc README README.ipv6 TODO
	else
		#only install /bin/hostname
		rm -rf ${D}/usr ${D}/sbin
		rm -f ${D}/bin/{domainname,netstat,dnsdomainname}
		rm -f ${D}/bin/{ypdomainname,nisdomainname}
	fi
}
