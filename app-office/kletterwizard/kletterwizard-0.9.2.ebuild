# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kletterwizard/kletterwizard-0.9.2.ebuild,v 1.1 2004/06/22 23:17:32 absinthe Exp $

IUSE=""

inherit kde
need-kde 3

MY_P=${P/_/"-"}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KLetterWizard is a KDE application which simplifies letter writing and produces output via LaTeX."
HOMEPAGE="http://www.kluenter.de/klw.html"
SRC_URI="http://www.kluenter.de/${MY_P}.tar.gz"
LICENSE="GPL-2"
DEPEND=">=app-text/tetex-2.0.2
		>=dev-tex/g-brief-4.0.1"
KEYWORDS="~x86 ~amd64"
