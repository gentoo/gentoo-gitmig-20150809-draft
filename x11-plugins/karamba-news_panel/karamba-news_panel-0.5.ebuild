# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/karamba-news_panel/karamba-news_panel-0.5.ebuild,v 1.1 2003/05/04 03:47:34 prez Exp $

DESCRIPTION="RSS News plugin for Karamba"
HOMEPAGE="http://www.kdelook.org/content/show.php?content=5891"
SRC_URI="http://www.kdelook.org/content/files/5891-news_panel-${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND=">=x11-misc/superkaramba-0.21"

src_unpack () {
	unpack ${A}
	mv news_panel-${PV} ${P}
}

src_compile () {
	echo -n ""
}

src_install () {
	dodir /usr/share/karamba/bin /usr/share/karamba/themes/news_panel
	cp rdf.pl ${D}/usr/share/karamba/bin
	chmod 755 ${D}/usr/share/karamba/bin/rdf.pl

	cp news_panel.py ${D}/usr/share/karamba/themes/news_panel/barrapunto.py
	cp news_panel.theme ${D}/usr/share/karamba/themes/news_panel/barrapunto.theme

	sed -e 's#barrapunto.com/barrapunto.rdf#www.bsdtoday.com/backend/bt.rdf#' \
		-e 's#pics/barrapunto.png#pics/bsdlogo.png#' \
		news_panel.py > ${D}/usr/share/karamba/themes/news_panel/bsdtoday.py
	cp news_panel.theme ${D}/usr/share/karamba/themes/news_panel/bsdtoday.theme

	sed -e 's#barrapunto.com/barrapunto.rdf#www.cnn.com/cnn.rss#' \
		-e 's#pics/barrapunto.png#pics/cnn.gif#' \
		news_panel.py > ${D}/usr/share/karamba/themes/news_panel/cnn.py
	cp news_panel.theme ${D}/usr/share/karamba/themes/news_panel/cnn.theme

	sed -e 's#barrapunto.com/barrapunto.rdf#www.dvdreview.com/rss/newschannel.rss#' \
		-e 's#pics/barrapunto.png#pics/dvsreview.gif#' \
		news_panel.py > ${D}/usr/share/karamba/themes/news_panel/dvdreview.py
	cp news_panel.theme ${D}/usr/share/karamba/themes/news_panel/dvdreview.theme

	sed -e 's#barrapunto.com/barrapunto.rdf#freshmeat.net/backend/fm.rdf#' \
		-e 's#pics/barrapunto.png#pics/freshmeat.gif#' \
		news_panel.py > ${D}/usr/share/karamba/themes/news_panel/freshmeat.py
	cp news_panel.theme ${D}/usr/share/karamba/themes/news_panel/freshmeat.theme

	sed -e 's#barrapunto.com/barrapunto.rdf#www.kde.org/news/kdenews.rdf#' \
		-e 's#pics/barrapunto.png#pics/kde_logo.jpg#' \
		news_panel.py > ${D}/usr/share/karamba/themes/news_panel/kdenews.py
	cp news_panel.theme ${D}/usr/share/karamba/themes/news_panel/kdenews.theme

	sed -e 's#barrapunto.com/barrapunto.rdf#www.newsisfree.com/export.php3?_f=rss91&amp;_w=f&amp;_i=1443#' \
		-e 's#pics/barrapunto.png#pics/niflogo.gif#' \
		news_panel.py > ${D}/usr/share/karamba/themes/news_panel/newsisfree.py
	cp news_panel.theme ${D}/usr/share/karamba/themes/news_panel/newsisfree.theme

	sed -e 's#barrapunto.com/barrapunto.rdf#www.slashdot.org/slashdot.rdf#' \
		-e 's#pics/barrapunto.png#pics/slashdot.gif#' \
		news_panel.py > ${D}/usr/share/karamba/themes/news_panel/slashdot.py
	cp news_panel.theme ${D}/usr/share/karamba/themes/news_panel/slashdot.theme

	sed -e 's#barrapunto.com/barrapunto.rdf#www.thinkgeek.com/thinkgeek.rdf#' \
		-e 's#pics/barrapunto.png#pics/tg-logo.gif#' \
		news_panel.py > ${D}/usr/share/karamba/themes/news_panel/thinkgeek.py
	cp news_panel.theme ${D}/usr/share/karamba/themes/news_panel/thinkgeek.theme

	cp -r pics ${D}/usr/share/karamba/themes/news_panel
	chmod -R go=u,go-w ${D}/usr/share/karamba/themes/news_panel

	dodoc README CHANGELOG INSTALL LICENSE RDFS TODO
}
