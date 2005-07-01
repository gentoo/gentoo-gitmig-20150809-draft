# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SSLeay/Net-SSLeay-1.25.ebuild,v 1.10 2005/07/01 05:36:16 kumba Exp $

inherit perl-module multilib

MY_P=${PN/-/_}.pm-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Net::SSLeay module for perl"
HOMEPAGE="http://www.cpan.org/authors/id/SAMPO/${MY_P}.readme"
SRC_URI="mirror://cpan/authors/id/SAMPO/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND="dev-libs/openssl"

export OPTIMIZE="$CFLAGS"

myconf="${myconf} /usr"

src_unpack() {
	unpack ${A}
	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e "s:openssl_path/lib:openssl_path/$(get_libdir):" \
		${S}/Makefile.PL || die
	fi
}
