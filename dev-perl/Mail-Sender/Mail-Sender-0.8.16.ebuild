# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Sender/Mail-Sender-0.8.16.ebuild,v 1.1 2008/09/07 09:48:42 tove Exp $

MODULE_AUTHOR=JENDA
inherit perl-module

DESCRIPTION="Module for sending mails with attachments through an SMTP server"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~x86"
IUSE=""

DEPEND="virtual/perl-MIME-Base64
	dev-lang/perl"

src_compile() {
	echo "n" | perl-module_src_compile
}
