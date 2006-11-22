# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mailody/mailody-0.2.0_rc1.ebuild,v 1.1 2006/11/22 13:41:28 flameeyes Exp $

inherit kde

MY_P="${P/_/-}"

DESCRIPTION="IMAP mail client for KDE"
HOMEPAGE="http://www.mailody.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86-fbsd"
IUSE=""

RDEPEND="=dev-db/sqlite-3*
	app-crypt/qca-tls"

S="${WORKDIR}/${MY_P}"

PATCHES="${FILESDIR}/${P}-dovecot.patch"

need-kde 3.5
