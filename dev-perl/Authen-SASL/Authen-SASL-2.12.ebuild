# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-SASL/Authen-SASL-2.12.ebuild,v 1.5 2008/09/03 17:27:39 armin76 Exp $

MODULE_AUTHOR="GBARR"
inherit perl-module

DESCRIPTION="A Perl SASL interface"
HOMEPAGE="http://search.cpan.org/~gbarr/"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha ~amd64 ~hppa ia64 ~ppc ~ppc64 sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="kerberos"
SRC_TEST="do"

export OPTIMIZE="$CFLAGS"
DEPEND="dev-lang/perl
		dev-perl/Digest-HMAC
		kerberos? ( dev-perl/GSSAPI )"
