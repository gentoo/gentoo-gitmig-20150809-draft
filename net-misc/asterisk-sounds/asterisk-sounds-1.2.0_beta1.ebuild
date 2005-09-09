# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-sounds/asterisk-sounds-1.2.0_beta1.ebuild,v 1.1 2005/09/09 18:58:28 stkn Exp $

inherit eutils

IUSE=""

MY_P="${P/_/-}"

DESCRIPTION="Additional sounds for Asterisk"
HOMEPAGE="http://www.asterisk.org/"
SRC_URI="http://ftp.digium.com/pub/asterisk/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~hppa ~amd64 ~ppc"

DEPEND="net-misc/asterisk"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}

	cd ${S}

	# some descriptions missing are missing the .gsm extension, fix them
	# make install fails otherwise
	epatch ${FILESDIR}/${P}-description.diff
}

src_install() {
	make DESTDIR=${D} install || die "Make install failed"

	dodoc README.txt sounds-extra.txt

	# fix permissions
	if has_version ">=net-misc/asterisk-1.0.5-r2"; then
		chown -R asterisk:asterisk ${D}var/lib/asterisk
		chmod -R u=rwX,g=rX,o=     ${D}var/lib/asterisk
	fi
}
