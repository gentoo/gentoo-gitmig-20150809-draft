# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/java-virtuals/transaction-api/transaction-api-1.1.ebuild,v 1.3 2010/05/02 12:05:32 betelgeuse Exp $

EAPI=1

inherit java-virtuals-2

DESCRIPTION="Virtual for Transaction API (javax.transaction)"
HOMEPAGE="http://www.gentoo.org"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="|| (
			dev-java/glassfish-transaction-api:0
			dev-java/jta:0
		)
		"

JAVA_VIRTUAL_PROVIDES="glassfish-transaction-api jta"
