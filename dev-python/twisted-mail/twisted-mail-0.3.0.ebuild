# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-mail/twisted-mail-0.3.0.ebuild,v 1.11 2007/03/16 23:25:36 vapier Exp $

MY_PACKAGE=Mail

inherit twisted

DESCRIPTION="A Twisted Mail library, server and client."

KEYWORDS="alpha amd64 arm hppa ia64 ~ppc ppc64 s390 sh sparc x86"

DEPEND="=dev-python/twisted-2.4*
	>=dev-python/twisted-names-0.2.0"
