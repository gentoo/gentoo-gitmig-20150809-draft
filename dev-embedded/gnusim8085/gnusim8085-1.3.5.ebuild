# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gnusim8085/gnusim8085-1.3.5.ebuild,v 1.3 2011/04/10 17:36:48 tomka Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A GTK2 8085 Simulator"
HOMEPAGE="http://sourceforge.net/projects/gnusim8085"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE="nls doc"

RDEPEND=">=x11-libs/gtk+-2.12:2
	>=gnome-base/libgnomeui-2.0
	x11-libs/gtksourceview:2.0"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_prepare() {
	# We'll install data properly
	sed -i \
		-e "s:install-exec-am install-data-am:install-exec-am:" \
		-e "s:SUBDIRS = intl po macros src pixmaps doc:SUBDIRS = intl po macros src pixmaps:" \
		"${S}"/Makefile.in \
		|| die "Patch failed"
	sed -i -e "s:share/pixmaps/\${PACKAGE}:share/pixmaps/:" "${S}"/configure || die "Patch failed"
}

src_configure() {
	myconf="${myconf} --prefix=${D}/usr $(use_enable nls)"
	econf ${myconf} || die "Configuration failed"
}

src_install() {
	emake install || die "Installation Failed!"

	dodoc AUTHORS ChangeLog NEWS README TODO || die "dodoc failed"
	doman doc/gnusim8085.1 || die "domain failed"

	if use doc; then
		insinto /usr/share/doc/${PF}/examples
		doins doc/examples/*.asm || die "doins examples failed"
		dodoc doc/asm-guide.txt || die "dodoc asm-guide failed"
	fi
	make_desktop_entry gnusim8085 GNUSim8085 gnusim8085_icon Development
}
