# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/gproftpd/gproftpd-8.1.4.ebuild,v 1.6 2004/07/15 00:00:18 agriffis Exp $

DESCRIPTION="GTK frontend to proftpd"
HOMEPAGE="http://mange.dynup.net/linux.html"
SRC_URI="http://mange.dynup.net/linux/gproftpd/${P}.tar.gz"
LICENSE="GPL-2"

KEYWORDS="x86 ~sparc"

SLOT="0"

IUSE="gnome"

# Requiring ProFTPD 1.2.9 due to security fixes
DEPEND=">=net-ftp/proftpd-1.2.9
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	>=x11-libs/pango-1.0
	>=dev-libs/atk-1.0
	>=media-libs/freetype-2.0"

#	>=x11-libs/xft-2.0  //this is blocked by xfree4.3.99

src_compile() {
	econf --sysconfdir=/etc/proftpd || die "./configure failed"
	emake || die "Build failure"
}

src_install () {
	einstall || die "Installation failure"

#         Add the Gnome menu entry
	if use gnome ; then
		insinto /usr/share/gnome/apps/Internet/
		doins ${FILESDIR}/gproftpd.desktop
	fi

	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}

pkg_postinst() {
	einfo "gproftpd looks for your proftpd.conf file in /etc/proftpd"
	einfo "run gproftpd with the option -c to specify an alternate location"
	einfo "ex: gproftpd -c /etc/proftpd.conf"
	ewarn "Do NOT edit /etc/conf.d/proftpd with this program"
}
