# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/wxruby/wxruby-0.4.0.ebuild,v 1.4 2004/08/02 17:20:30 fmccor Exp $

MY_P="${PN}-${PV}-src"
DESCRIPTION="Ruby language bindings for the wxWidgets GUI toolkit"
HOMEPAGE="http://rubyforge.org/projects/wxruby/"
SRC_URI="http://rubyforge.org/frs/download.php/769/${MY_P}.tgz"
LICENSE="wxWinLL-3"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="unicode"
DEPEND=">=dev-lang/ruby-1.8
	>=x11-libs/wxGTK-2.4.1"
S=${WORKDIR}/${MY_P}

pkg_setup() {
	use unicode && die "${CATEGORY}/${PN} is incompatible with USE=\"unicode\""
}

src_compile() {
	( cd src && ruby extconf.rb && emake ) || die
}

src_install() {
	dodoc [A-Z]*
	cp -r samples ${D}/usr/share/doc/${PF}
	( cd src && make DESTDIR=${D} install )
}
