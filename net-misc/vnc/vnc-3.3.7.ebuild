# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/vnc/vnc-3.3.7.ebuild,v 1.3 2003/05/04 14:58:45 aliz Exp $

inherit eutils

IUSE="java tcpd"

MY_P="${P}-unixsrc"

DESCRIPTION="Remote desktop viewer display system"
HOMEPAGE="http://www.realvnc.com/"

SRC_URI="http://www.realvnc.com/dist/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )
	!net-misc/tightvnc"
RDEPEND="java? ( virtual/jre )"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.security.patch
}

src_compile() {
	
	export CXX="g++"

	econf || die "./configure failed"

	make 
	
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

