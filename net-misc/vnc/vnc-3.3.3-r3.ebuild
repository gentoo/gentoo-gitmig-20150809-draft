# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /home/cvsroot/gentoo-x86/skel.build,v 1.2 2001/02/15 18:17:31 achim Exp
# $Header: /var/cvsroot/gentoo-x86/net-misc/vnc/vnc-3.3.3-r3.ebuild,v 1.1 2002/09/03 08:09:46 seemant Exp $

inherit flag-o-matic

MY_P="vnc-3.3.3r2_unixsrc"
S=${WORKDIR}/vnc_unixsrc
S2=${WORKDIR}/vnc-gentoo-extra
DESCRIPTION="A remote display system which allows you to view a computing 'desktop' environment from anywhere."
SRC_URI="http://www.uk.research.att.com/vnc/dist/${MY_P}.tgz
	mirror://gentoo/${P}-gentoo-extra.tar.bz2"
HOMEPAGE="http://www.uk.research.att.com/vnc/index.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/x11
	tcpd? ( sys-apps/tcp-wrappers )
	java? ( virtual/jre )"


src_unpack() {
	unpack ${A}
	cd ${S}

	# apply Mandrake's patches
	bzcat ${S2}/${P}-gentoo.diff.bz2 | patch -p1 || die

	if use tcpd
	then
		bzcat ${S2}/${P}r2-tcpwrappers.patch.bz2 | patch -p1 || die
	fi

	if use ppc
	then
		bzcat ${S2}/vnc-ppc.patch.bz2 | patch -p0 || die
	fi

}

src_compile() {
	xmkmf || die

	make \
		CDEBUGFLAGS="${CFLAGS}" \
		World || die

	cd Xvnc
	if use tcpd
	then
		make \
			EXTRA_LIBRARIES="-lwrap -lnss_nis" \
			CDEBUGFLAGS="${CFLAGS}" \
			World || die
	else
		make \
			CDEBUGFLAGS="${CFLAGS}" \
			World || die
	fi
}

src_install () {
	dodir /usr/bin
	./vncinstall ${D}/usr/bin || die

	#install manpages
	doman ${S2}/*.1
}
