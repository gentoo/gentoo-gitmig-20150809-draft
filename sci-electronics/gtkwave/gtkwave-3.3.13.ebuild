# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gtkwave/gtkwave-3.3.13.ebuild,v 1.1 2010/09/29 01:30:38 rafaelmartins Exp $

EAPI="2"

DESCRIPTION="A wave viewer for LXT, LXT2, VZT, GHW and standard Verilog VCD/EVCD files"
HOMEPAGE="http://gtkwave.sourceforge.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

IUSE="doc examples fasttree fatlines judy tcl xz"
LICENSE="GPL-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2
	x11-libs/pango
	judy? ( dev-libs/judy )
	tcl? ( dev-lang/tcl dev-lang/tk )
	xz? ( app-arch/xz-utils )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/gperf"

src_prepare(){
	sed -i -e 's/doc examples//' Makefile.in || die "sed failed"
}

src_configure(){
	econf --disable-local-libz \
		--disable-local-libbz2 \
		--disable-dependency-tracking \
		--enable-largefile \
		$(use_enable fatlines) \
		$(use_enable tcl) \
		$(use_enable xz) \
		$(use_enable fasttree) \
		$(use_enable judy)
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc ANALOG_README.TXT SYSTEMVERILOG_README.TXT CHANGELOG.TXT
	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins "doc/${PN}.odt" || die "Failed to install documentation."
	fi
	if use examples ; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die "Failed to install examples."
	fi
}
