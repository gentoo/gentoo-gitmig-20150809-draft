# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/mta/mta-0.ebuild,v 1.1 2011/03/28 07:06:34 eras Exp $

EAPI=3

DESCRIPTION="Virtual for Message Transfer Agents"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~x64-freebsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="|| (	mail-mta/ssmtp
				mail-mta/courier
				mail-mta/esmtp
				mail-mta/exim
				mail-mta/mini-qmail
				mail-mta/msmtp
				mail-mta/nbsmtp
				mail-mta/netqmail
				mail-mta/nullmailer
				mail-mta/postfix
				mail-mta/qmail-ldap
				mail-mta/sendmail )"
