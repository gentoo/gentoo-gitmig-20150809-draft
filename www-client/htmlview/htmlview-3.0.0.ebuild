# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/htmlview/htmlview-3.0.0.ebuild,v 1.1 2004/11/12 10:48:52 usata Exp $

inherit rpm

IUSE=""

RH_EXTRAVERSION="8"

DESCRIPTION="A script which calls an installed HTML viewer."
HOMEPAGE="http://www.redhat.com"
SRC_URI="mirror://fedora/development/SRPMS/${P}-${RH_EXTRAVERSION}.src.rpm"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86"

S=${WORKDIR}

src_compile() {
	sed -i -e '{ /^TERMS_GENERIC/s:"\(.*\)":"\1 /usr/bin/aterm /usr/bin/hanterm /usr/bin/kterm /usr/bin/mlterm /usr/bin/mrxvt /usr/bin/urxvt":
		/^TTYBROWSERS/s:"\(.*\)":"\1 /usr/bin/elinks":
		/^X11BROWSERS_GNOME/s:"\(.*\)":"\1 /usr/bin/kazehakase":
		/^X11BROWSERS_GENERIC/s:"\(.*\)":"\1 /usr/bin/firefox":
		}' htmlview || die
}

src_install () {
	dobin htmlview
	dobin launchmail
}
