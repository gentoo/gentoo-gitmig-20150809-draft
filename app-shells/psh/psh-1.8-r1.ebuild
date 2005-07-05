# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/psh/psh-1.8-r1.ebuild,v 1.3 2005/07/05 23:11:08 swegener Exp $

inherit perl-module

DESCRIPTION="Combines the interactive nature of a Unix shell with the power of Perl"
HOMEPAGE="http://www.focusresearch.com/gregor/psh/"
SRC_URI="http://www.focusresearch.com/gregor/psh/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~ia64 ~amd64"
IUSE="readline"

DEPEND=">=dev-lang/perl-5"
RDEPEND="readline? (
	dev-perl/Term-ReadLine-Perl
	dev-perl/TermReadKey )"

myinst="SITEPREFIX=${D}/usr"
