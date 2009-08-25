# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-i18n-langtags/perl-i18n-langtags-0.35.ebuild,v 1.2 2009/08/25 10:56:43 tove Exp $

DESCRIPTION="Virtual for I18N-LangTags"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~dev-lang/perl-5.8.8 ~perl-core/i18n-langtags-${PV} )"
