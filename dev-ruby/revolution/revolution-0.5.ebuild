# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/revolution/revolution-0.5.ebuild,v 1.1 2008/03/31 18:42:42 graaff Exp $

inherit gems

DESCRIPTION="Ruby binding for the Evolution email client."
HOMEPAGE="http://revolution.rubyforge.org/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=gnome-extra/evolution-data-server-1.12"
RDEPEND="${DEPEND}"
