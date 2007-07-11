# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/verbiste/verbiste-0.1.16.ebuild,v 1.7 2007/07/11 05:41:19 mr_bones_ Exp $

inherit autotools eutils

DESCRIPTION="French conjugation system"
HOMEPAGE="http://www3.sympatico.ca/sarrazip/dev/verbiste.html"
SRC_URI="http://www3.sympatico.ca/sarrazip/dev/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

IUSE="gnome"

RDEPEND=">=dev-libs/libxml2-2.4.0
	gnome? ( >=gnome-base/gnome-panel-2.0
		>=gnome-base/libgnomeui-2.0 )"

DEPEND="${RDEPEND}
	sys-devel/gettext"

#from enlightenment eclass
gettext_modify() {
#        use nls || return 0
	cp $(type -P gettextize) "${T}"/ || die "could not copy gettextize"
	sed -i \
		-e 's:read dummy < /dev/tty::' \
		"${T}"/gettextize
}

src_unpack() {
	unpack ${A}

	gettext_modify

	cd ${S}
	"${T}"/gettextize --force --intl --copy
	AT_M4DIR=macros eautoreconf
}

src_compile() {
	econf $(use_with gnome) || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die "can't install"
	dodoc AUTHORS ChangeLog HACKING LISEZMOI NEWS README THANKS TODO
}
