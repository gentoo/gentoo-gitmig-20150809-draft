# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/libapreq/libapreq-1.3.3.ebuild,v 1.1 2007/05/05 20:35:22 mcummings Exp $

inherit perl-module versionator eutils

MY_PV="$(delete_version_separator 2)"
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Apache Request Perl Module"
HOMEPAGE="http://httpd.apache.org/apreq/"
SRC_URI="http://www.apache.org/dist/httpd/libapreq/${MY_P}.tar.gz"

LICENSE="Apache-1.1 as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=sys-apps/sed-4
	dev-perl/Apache-Test
	<www-apache/mod_perl-1.99"

mydoc="TODO"
