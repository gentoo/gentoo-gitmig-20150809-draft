# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-sounds-de-pforzheim/asterisk-sounds-de-pforzheim-2005.09.11.ebuild,v 1.2 2010/10/28 10:46:55 ssuominen Exp $

DESCRIPTION="German voice prompts for Asterisk from the City of Pforzheim"
HOMEPAGE="http://www.stadt-pforzheim.de/asterisk/"
SRC_URI="http://www.stadt-pforzheim.de/asterisk/dateien/ast_prompts_de_v2_0.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=net-misc/asterisk-1.2.0"

S="${WORKDIR}/ast_prompts_de_v2_0/var/lib/asterisk/sounds"

src_install() {
	insinto /var/lib/asterisk/sounds
	doins -r .

	# fix permissions
	if has_version ">=net-misc/asterisk-1.0.5-r2"; then
		chown -R asterisk:asterisk "${D}"var/lib/asterisk
		chmod -R u=rwX,g=rX,o=     "${D}"var/lib/asterisk
	fi
}
