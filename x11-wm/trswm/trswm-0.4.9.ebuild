# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/trswm/trswm-0.4.9.ebuild,v 1.2 2004/02/17 07:32:55 mr_bones_ Exp $

DESCRIPTION="An ion-based window manager that aims to provide a desktop environment based on the keyboard, making the mouse optional"
HOMEPAGE="http://www.relex.ru/~yarick/trswm/"
SRC_URI="http://www.relex.ru/~yarick/${PN}/${P}.tar.gz"
LICENSE="as-is"

IUSE="debug"
SLOT="0"
KEYWORDS="~alpha ~hppa ~mips ~sparc ~x86"

DEPEND="virtual/x11
	>=dev-lang/lua-5"

src_compile() {

	local debugconf=""
	use debug \
		&& debugconf="--with-debug=2" \
		|| debugconf="--with-debug=0"

	econf ${debugconf} || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install  || die
	# move the real window manager binary away, and install
	# our own wrapper script in its place
	mv ${D}/usr/bin/trswm ${D}/usr/bin/trswm.bin
	dobin ${FILESDIR}/trswm

	dodoc BUGS Roadmap TODO

}

pkg_postinst() {

	einfo "To use trswm please use \"exec trswm\" in ~/.xinitrc."
	echo ""
	einfo "The trswm script installed here is a wrapper around the"
	einfo "trswm binary (trswm.bin), which will install the"
	einfo "necessary configuration files in \$HOME/.trswm-devel/"
	einfo "Please see trswm --help for additional usage information."
	echo ""

}

