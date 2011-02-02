# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knutclient/knutclient-1.0.2.ebuild,v 1.2 2011/02/02 05:26:10 tampakrap Exp $

EAPI=3
KDE_LINGUAS="cs de es fr it pl pt_BR ru uk"
inherit kde4-base

DESCRIPTION="A visual KDE client for UPS systems"
HOMEPAGE="http://sites.google.com/a/prynych.cz/knutclient/"
SRC_URI="ftp://ftp.buzuluk.cz/pub/alo/knutclient/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug +handbook"

DOCS=( AUTHORS ChangeLog README )
