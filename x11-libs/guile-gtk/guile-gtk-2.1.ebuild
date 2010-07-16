# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/guile-gtk/guile-gtk-2.1.ebuild,v 1.6 2010/07/16 09:56:16 fauli Exp $

EAPI="2"

inherit autotools eutils virtualx

DESCRIPTION="GTK+ bindings for guile"
HOMEPAGE="http://www.gnu.org/software/guile-gtk/"
SRC_URI="ftp://ftp.gnu.org/gnu/guile-gtk/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

RDEPEND="dev-scheme/guile
	=x11-libs/gtk+-2*
	=gnome-base/libglade-2*
	>=x11-libs/gtkglarea-1.90"
DEPEND="${RDEPEND}"

pkg_setup() {
	if has_version =dev-scheme/guile-1.8*; then
		local flags="deprecated"
		built_with_use dev-scheme/guile ${flags} \
			|| die "guile must be built with \"${flags}\" use flag"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${PN}-2.0-g-object-ref.diff"
	epatch "${FILESDIR}"/${PV}-prll-install.patch
	epatch "${FILESDIR}"/${PV}-brokentest.patch
	eautoreconf
}

src_test() {
	Xemake check || die "tests failed"
}

src_install() {
	# bug #298803
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README AUTHORS ChangeLog NEWS TODO
	insinto /usr/share/doc/${PF}/examples
	doins -r examples/
}
