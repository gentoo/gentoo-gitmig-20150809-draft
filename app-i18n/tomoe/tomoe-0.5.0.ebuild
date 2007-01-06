# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/tomoe/tomoe-0.5.0.ebuild,v 1.1 2007/01/06 05:50:28 matsuu Exp $

DESCRIPTION="Japanese handwriting recognition engine"
HOMEPAGE="http://tomoe.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/tomoe/23340/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ruby"
#IUSE="hyperestraier mysql ruby subversion"

RDEPEND=">=dev-libs/glib-2.4
	ruby? ( dev-ruby/ruby-glib2 )"
#	hyperestraier? ( app-text/hyperestraier )
#	subversion? ( dev-util/subversion )
#	mysql? ( dev-db/mysql )

DEPEND="${DEPEND}
	dev-util/pkgconfig"

RESTRICT="test"

src_compile() {
	econf $(use_with ruby) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS ChangeLog NEWS TODO
}
