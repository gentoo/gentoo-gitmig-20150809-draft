# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/digitaldj/digitaldj-0.7.3.ebuild,v 1.2 2003/06/17 16:19:40 twp Exp $

DESCRIPTION="A SQL-based mp3-player frontend designed to work with Grip"
HOMEPAGE="http://www.nostatic.org/ddj/"
SRC_URI="http://www.nostatic.org/ddj/${P}.tar.gz"
LICENSE="GPL-1"
SLOT="0"
KEYWORDS="~alpha ~arm ~hppa ~mips ~sparc ~x86"
IUSE=""
DEPEND="dev-db/mysql
	gnome-base/libghttp
	media-libs/gdk-pixbuf
	media-sound/grip
	>=x11-libs/gtk+-1.2"

src_compile() {
	econf --disable-lirc
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	einfo "To create the DDJ database run"
	einfo "	ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config"
}

pkg_config() {
	local sql=`mktemp digitaldj.XXXXXXXXXX` || die "mktemp failed"
	echo "CREATE DATABASE IF NOT EXISTS ddj_mp3;" >> ${sql}
	echo "USE ddj_mp3;" >> ${sql}
	cat ${ROOT}/usr/share/digitaldj/0-2.sql >> ${sql}
	echo "Type in your MySQL root password:"
	mysql -u root -p < ${sql}
	rm -f ${sql}
}
