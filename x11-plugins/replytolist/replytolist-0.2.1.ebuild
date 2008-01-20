# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/replytolist/replytolist-0.2.1.ebuild,v 1.4 2008/01/20 17:14:19 ranger Exp $

inherit mozextension multilib

DESCRIPTION="Thunderbird extension to reply to mailing list"
HOMEPAGE="http://alumnit.ca/wiki/index.php?page=ReplyToListThunderbirdExtension"
SRC_URI="http://alumnit.ca/wiki/attachments/${P}.xpi"

KEYWORDS="alpha ~amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND=">=mail-client/mozilla-thunderbird-2.0_alpha1
		>=x11-plugins/enigmail-0.94.1-r1"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	xpi_unpack ${P}.xpi
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/mozilla-thunderbird"

	xpi_install "${S}"/${P}
}
