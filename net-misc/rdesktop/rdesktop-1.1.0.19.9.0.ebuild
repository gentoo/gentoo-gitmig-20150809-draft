# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdesktop/rdesktop-1.1.0.19.9.0.ebuild,v 1.6 2003/09/05 22:13:37 msterret Exp $

PATCH_PV="19-9-0"
PATCH_PV_SED=".${PATCH_PV//-/.}"
MY_P=${P/$PATCH_PV_SED}
S=${WORKDIR}/${MY_P}
DESCRIPTION="A Remote Desktop Protocol Client"
HOMEPAGE="http://rdesktop.sourceforge.net/"
SRC_URI="mirror://sourceforge/rdesktop/${MY_P}.tar.gz
	http://bibl4.oru.se/projects/rdesktop/rdesktop-unified-patch${PATCH_PV}.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"
IUSE="ssl debug"

DEPEND="virtual/x11
	ssl? ( >=dev-libs/openssl-0.9.6b )"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/rdesktop-unified-patch${PATCH_PV}.bz2
}

src_compile() {
	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		`use_with ssl openssl` \
	        `use_with debug` \
		|| die

	use ssl && echo "CFLAGS += -I/usr/include/openssl" >> Makeconf

	# Hold on tight folks, this ain't purdy
	if [ ! -z "${CXXFLAGS}" ]; then
		sed -e 's:-O2::g' Makefile > Makefile.tmp
		mv Makefile.tmp Makefile
		echo "CFLAGS += ${CXXFLAGS}" >> Makeconf
	fi

	make localendian.h || die
	emake || die "compile problem"
}

src_install() {
	dobin rdesktop
	doman rdesktop.1
	dodoc COPYING CHANGES readme.txt rdp-srvr-readme.txt
}
