# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/supersed/supersed-3.60.ebuild,v 1.9 2004/07/22 04:33:53 vapier Exp $

MY_P=sed-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An enhanced version of sed which sports greater speed and the use of perl regular expressions than GNU sed."
HOMEPAGE="http://sed.sourceforge.net/grabbag/ssed/"
SRC_URI="http://sed.sourceforge.net/grabbag/ssed/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc mips ~alpha amd64"
IUSE="nls static"

DEPEND="virtual/libc
	>=sys-apps/portage-2.0.45-r3
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/libc"

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
		`use_enable nls` || die "econf failed"

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
