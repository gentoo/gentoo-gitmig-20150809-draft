# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/supersed/supersed-3.60.ebuild,v 1.3 2003/06/21 21:19:41 drobbins Exp $

IUSE="nls static"

MY_P=sed-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An enhanced version of sed which sports greater speed and the use of perl regular expressions than GNU sed."
SRC_URI="http://sed.sourceforge.net/grabbag/ssed/${MY_P}.tar.gz"
HOMEPAGE="http://queen.rett.polimi.it/~paolob/seders/ssed/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 mips"

DEPEND="virtual/glibc
	>=sys-apps/portage-2.0.45-r3
	nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A} && cd ${S}/doc

	# Adjust info files
	local i
	for i in sed.info*; do
		sed 's/^\* sed: (sed)/\* ssed: (ssed)/; s/sed.info/ssed.info/' $i > s$i
	done
}

src_compile() {
	econf	--program-prefix=s \
		`use_enable nls`

	if use static; then
		emake LDFLAGS="-static" || die "make failed"
	else
		emake || die "make failed"
	fi
}

src_install() {
	einstall

	rm -Rf ${D}/usr/share/info/
	doinfo doc/ssed.info*
	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog NEWS README* THANKS TODO
}
