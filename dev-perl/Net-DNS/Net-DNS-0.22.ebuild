# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DNS/Net-DNS-0.22.ebuild,v 1.2 2002/07/25 04:13:27 seemant Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Net::DNS - Perl DNS Resolver Module"
SRC_URI="http://www.net-dns.org/download/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.fuhr.org/~mfuhr/perldns/"

newdepend "dev-perl/Digest-HMAC dev-perl/MIME-Base64"
mydoc="TODO"
