# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/digitaldj/digitaldj-0.7.5.ebuild,v 1.4 2006/10/23 11:11:01 vivo Exp $

DESCRIPTION="A SQL-based mp3-player frontend designed to work with Grip"
HOMEPAGE="http://www.nostatic.org/ddj/"
SRC_URI="mirror://sourceforge/ddj/${P}.tar.gz"
LICENSE="GPL-1"
SLOT="0"
#-amd64: 0.7.3-r1: segfault when "attempt to configure database->yes"
KEYWORDS="~alpha -amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="lirc"
DEPEND="dev-db/mysql
	lirc? ( app-misc/lirc )
	gnome-base/libghttp
	media-libs/gdk-pixbuf
	media-sound/grip
	>=x11-libs/gtk+-1.2"

inherit eutils

src_unpack() {
	unpack ${A}
	cd "${S}"
	# CLK_TCK -> CLOCKS_PER_SEC
	epatch "${FILESDIR}/${PN}-remove_obsolete_CLK_TCK.patch"
}

src_compile() {
	econf `use_enable lirc` || die
	emake || die
}

src_install() {
	einstall
	dodoc AUTHORS ChangeLog README
}

pkg_postinst() {
	einfo "To create the DDJ database run"
	einfo " emerge --config =${CATEGORY}/${PF}"
}

pkg_config() {
	local sql=`mktemp digitaldj.XXXXXXXXXX` || die "mktemp failed"
	echo 'CREATE DATABASE IF NOT EXISTS ddj_mp3;' >> ${sql}
	echo 'GRANT SELECT, INSERT, UPDATE, DELETE ON ddj_mp3.* TO ddj@localhost;' >> ${sql}
	echo 'USE ddj_mp3;' >> ${sql}
	sed -e 's/^\(CREATE TABLE\)/\1 IF NOT EXISTS/g' ${ROOT}/usr/share/digitaldj/0-2.sql >> ${sql}
	less ${sql}
	echo "Type in your MySQL root password:"
	mysql -u root -p < ${sql}
	rm -f ${sql}
}
