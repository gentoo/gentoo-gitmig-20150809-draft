# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devhelp/devhelp-0.4-r1.ebuild,v 1.3 2002/07/23 13:28:37 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Developer help browser"
SRC_URI="http://devhelp.codefactory.se/download/${P}.tar.gz"
HOMEPAGE="http://devhelp.codefactory.se/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=gnome-base/gnome-libs-1.4.1.7 
	 >=gnome-base/ORBit-0.5.10-r1
	 >=gnome-base/bonobo-1.0.19
	 =gnome-base/libglade-0*
	 >=dev-libs/libxml-1.8.17
	 >=gnome-extra/gtkhtml-1.0.2
	 =gnome-base/gconf-1.0*
	 =gnome-base/gnome-vfs-1*
	 >=gnome-base/oaf-0.6.8-r1
	 >=gnome-base/gnome-print-0.30"

RDEPEND="nls? ( sys-devel/gettext
	>=dev-util/intltool-0.11 )"

src_compile() {
	local myconf

	use nls || myconf="--disable-nls"

	econf \
		--disable-more-warnings \
		--disable-install-schemas \
		--without-python \
		${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}

pkg_postinst() {
	# This is directly from the rpm specfile for devhelp...
	# Fix gconf permissions
	killall gconfd-1 2>/dev/null >/dev/null
	chmod o+rX /etc/gconf -R
	# Install schemas
	gconftool-1 --shutdown
	SOURCE=xml::/etc/gconf/gconf.xml.defaults
	GCONF_CONFIG_SOURCE=$SOURCE \
		gconftool-1 --makefile-install-rule \
		/etc/gconf/schemas/devhelp.schemas \ 
		|| die "gconftool-1 execution failed"
}
