# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/serienbrief/serienbrief-0.2-r2.ebuild,v 1.3 2008/11/18 16:02:25 tove Exp $

DESCRIPTION="Easy creation of form letters written in LaTeX"
HOMEPAGE="http://www.nasauber.de/programme/serienbrief/"
SRC_URI="http://www.nasauber.de/programme/serienbrief/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
LINS=("de")

for ((i=0; i<${#LINS[@]}; i++)) do
	IUSE="${IUSE} linguas_${LINS[$i]}"
done

KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND=">=dev-lang/perl-5.8.6
	virtual/perl-Getopt-Long
	>=virtual/perl-Term-ANSIColor-1.08
	>=dev-perl/Locale-gettext-1.01
	virtual/latex-base"

src_install() {
	dobin serienbrief
	doman serienbrief.1
	if use linguas_de; then
		insinto /usr/share/locale/de/LC_MESSAGES
		doins serienbrief.mo
	fi
	dodoc changelog example/*
}
