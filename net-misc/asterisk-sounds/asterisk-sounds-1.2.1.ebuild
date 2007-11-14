# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-sounds/asterisk-sounds-1.2.1.ebuild,v 1.3 2007/11/14 19:11:14 beandog Exp $

inherit eutils

IUSE=""

MY_P="${P/_/-}"

DESCRIPTION="Additional sounds for Asterisk"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://ftp.digium.com/pub/asterisk/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~hppa ~ppc sparc x86"

DEPEND=">=net-misc/asterisk-1.2.0"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR=${D} install || die "Make install failed"

	dodoc README.txt sounds-extra.txt

	# fix permissions
	if has_version ">=net-misc/asterisk-1.0.5-r2"; then
		chown -R asterisk:asterisk ${D}var/lib/asterisk
		chmod -R u=rwX,g=rX,o=     ${D}var/lib/asterisk
	fi
}
