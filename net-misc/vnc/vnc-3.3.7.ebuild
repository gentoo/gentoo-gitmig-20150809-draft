# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vnc/vnc-3.3.7.ebuild,v 1.11 2004/01/10 06:12:04 augustus Exp $

inherit eutils

MY_P="${P}-unixsrc"
DESCRIPTION="Remote desktop viewer display system"
HOMEPAGE="http://www.realvnc.com/"
SRC_URI="http://www.realvnc.com/dist/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc ~amd64"
IUSE="java tcpd"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )
	!net-misc/tightvnc"
RDEPEND="java? ( virtual/jre )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.security.patch
	epatch ${FILESDIR}/${P}-imake-tmpdir.patch
	if [ "${ARCH}" = "sparc" ]
	then
		epatch ${FILESDIR}/vnc-3.3.3r2-getline-fix.patch
		epatch ${FILESDIR}/vnc-3.3.4-platform-fixes.patch
		epatch ${FILESDIR}/vnc-3.3.3-10-xdm-auth-support.patch
	fi
	sed -i \
		's:CC = cc:CC = gcc:' \
		Xvnc/config/imake/Makefile.ini \
		Xvnc/config/util/Makefile.ini
}

src_compile() {

	export CXX="g++"

	econf || die "./configure failed"

	make

	use ppc && return 0
	use amd64 && return 0
	cd Xvnc
	if use tcpd
	then
		make \
			EXTRA_LIBRARIES="-lwrap -lnss_nis" \
			CDEBUGFLAGS="${CFLAGS}" \
			CXXFLAGS="${CFLAGS}" \
			World || die
	else
		make \
			CDEBUGFLAGS="${CFLAGS}" \
			CXXFLAGS="${CFLAGS}" \
			World || die
	fi

}

src_install () {

	dodir /usr/bin /usr/share/man/man1

	./vncinstall ${D}/usr/bin ${D}/usr/share/man || die

	if use java
	then
		cd ${S}/classes
		insinto /usr/share/vnc/classes
		doins *.class *.jar *.vnc
	fi

	cd ${S}
	dodoc LICENCE.TXT README

}

