# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/xwine/xwine-1.0.1.ebuild,v 1.1 2005/05/08 01:09:34 vapier Exp $

inherit eutils

DESCRIPTION="GTK+ frontend for Wine"
HOMEPAGE="http://darken33.free.fr/"
SRC_URI="http://darken33.free.fr/download/projets/xwine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

DEPEND="=x11-libs/gtk+-1*
	>=gnome-base/gnome-libs-1.4.2
	=gnome-base/orbit-0*
	dev-libs/libxml2
	=sys-libs/db-1*
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	make distclean || die "distclean failed"
	sed -i \
		-e 's: /usr/share/: $(DESTDIR)/usr/share/:g' \
		-e "s:/doc/\$(PACKAGE):/doc/${PF}:g" \
		-e "s: /etc/\$(PACKAGE)/apps: \$(DESTDIR)/etc/${PN}/apps:g" \
		Makefile.in || die "patching Makefile.in failed"
	cp menu/xwine.desktop .
}

src_compile() {
	econf $(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /usr/share/applications
	make install DESTDIR="${D}" || die "make install failed"
	dodoc AUTHORS BUGS ChangeLog INSTALL README TODO NEWS
	dohtml doc/en/FAQ.html doc/en/index.html
}
