# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mailody/mailody-0.5.0.ebuild,v 1.1 2007/06/20 17:34:20 philantrop Exp $

LANGS="ar bg br da de el es ga it ja nl pt pt_BR sk sv"
LANGS_DOC=""
USE_KEG_PACKAGING=1

inherit kde

MY_P="${P/_/-}"

DESCRIPTION="IMAP mail client for KDE"
HOMEPAGE="http://www.mailody.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="=dev-db/sqlite-3*
	app-crypt/qca-tls"

S="${WORKDIR}/${MY_P}"

need-kde 3.5
