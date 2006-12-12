# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws/sylpheed-claws-2.6.1.ebuild,v 1.2 2006/12/12 14:25:49 uberlord Exp $

IUSE=""
DESCRIPTION="Sylpheed-Claws is an email client (and news reader) based on GTK+"
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI=""
SLOT="0"
LICENSE="GPL-2"		# should be empty actually, but that makes repoman unhappy
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
RDEPEND=">=mail-client/claws-mail-${PV}"