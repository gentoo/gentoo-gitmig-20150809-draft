# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-SASL/Authen-SASL-2.13.ebuild,v 1.2 2010/01/09 16:31:20 grobian Exp $

EAPI=2

MODULE_AUTHOR=GBARR
inherit perl-module

DESCRIPTION="A Perl SASL interface"
HOMEPAGE="http://search.cpan.org/~gbarr/"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd ~ppc-aix ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos  ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="kerberos"

DEPEND="dev-perl/Digest-HMAC
		kerberos? ( dev-perl/GSSAPI )"
RDEPEND="${DEPEND}"

SRC_TEST="do"
export OPTIMIZE="$CFLAGS"
