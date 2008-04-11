# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/lastfmproxy/lastfmproxy-1.3b.ebuild,v 1.1 2008/04/11 23:39:07 yngwin Exp $

DESCRIPTION="A proxy server for listening to last.fm streams with any stream-capable audio player"
HOMEPAGE="http://vidar.gimp.org/lastfmproxy/"
SRC_URI="http://vidar.gimp.org/wp-content/uploads/2007/12/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=""
RDEPEND=""

src_install() {
	BASE=/usr/share/lastfmproxy
	cd "${S}"
	dodoc README.txt ChangeLog.txt

	insinto ${BASE}
	doins -r *.py data
	fperms 755 ${BASE}/changestation.py ${BASE}/main.py

	newinitd "${FILESDIR}"/lastfmproxy.rc lastfmproxy
}

pkg_postinst() {
	echo
	einfo "Please modify:"
	einfo "  /usr/share/lastfmproxy/config.py"
	einfo "with last.fm credentials and/or proxy information."
	einfo ""
	einfo "Then, to start lastfmproxy:"
	einfo "  /etc/init.d/lastfmproxy start"
	einfo ""
	einfo "Here's how to make the lastfm://station links work:"
	einfo '  In Firefox, open the location "about:config"'
	einfo '  Right-click, select "New String"'
	einfo '  As name, enter "network.protocol-handler.app.lastfm"'
	einfo '  As value, enter "/usr/share/lastfmproxy/changestation.py"'
	echo
}
