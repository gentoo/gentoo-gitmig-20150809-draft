# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellshoot/gkrellshoot-0.4.4.ebuild,v 1.5 2007/05/26 12:58:00 opfer Exp $

inherit gkrellm-plugin

S=${WORKDIR}/${P/s/S}
DESCRIPTION="GKrellm2 plugin to take screen shots and lock screen"
HOMEPAGE="http://gkrellshoot.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkrellshoot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha amd64 ppc sparc x86"
IUSE=""

RDEPEND="media-gfx/imagemagick"

