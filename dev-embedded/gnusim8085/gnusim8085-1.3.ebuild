# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/gnusim8085/gnusim8085-1.3.ebuild,v 1.4 2011/03/21 22:52:31 nirbheek Exp $

EAPI="1"

inherit eutils

DESCRIPTION="A GTK2 8085 Simulator"
HOMEPAGE="http://sourceforge.net/projects/gnusim8085"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-2.0:2
	>=gnome-base/libgnomeui-2.0
	x11-libs/gtksourceview:1.0
	nls? ( >=sys-devel/gettext-0.10.40 )"

src_unpack() {
	unpack ${A}

	# We'll install data properly
	sed -i \
		-e "s:install-exec-am install-data-am:install-exec-am:" \
		-e "s:SUBDIRS = intl po macros src pixmaps doc:SUBDIRS = intl po macros src pixmaps:" \
		${S}/Makefile.in \
		|| die "Patch failed"
	sed -i -e "s:share/pixmaps/\${PACKAGE}:share/pixmaps/:" ${S}/configure || die "Patch failed"
}

src_compile() {
	econf $(use_enable nls) || die "Configuration failed"
	emake gnusim8085_LDADD='$(GNOME_LIBS)' || die "Compilation failed"
}

src_install() {
	einstall || die "Installation Failed!"

	cd ${S}
	dodoc README doc/asm_reference.txt AUTHORS ChangeLog NEWS TODO
	doman doc/gnusim8085.1

	insinto /usr/share/doc/${PF}/examples
	doins doc/examples/*.asm

	make_desktop_entry gnusim8085 GNUSim8085 gnusim8085_icon Development
}
