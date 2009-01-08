# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-mail/twisted-mail-8.1.0.ebuild,v 1.9 2009/01/08 22:55:43 patrick Exp $

MY_PACKAGE=Mail

inherit twisted versionator

DESCRIPTION="A Twisted Mail library, server and client"

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"

DEPEND="=dev-python/twisted-$(get_version_component_range 1-2)*
	>=dev-python/twisted-names-0.2.0"

IUSE=""
