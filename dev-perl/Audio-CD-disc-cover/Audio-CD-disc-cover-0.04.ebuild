# Copyright 2002 Felix Kurth <felix@fkurth.de>
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Audio-CD-disc-cover/Audio-CD-disc-cover-0.04.ebuild,v 1.1 2002/06/19 00:15:57 agenkin Exp $

DESCRIPTION="Perl Module needed for app-cdr/disc-cover"
HOMEPAGE="http://www.liacs.nl/~jvhemert/disc-cover"

DEPEND=">=dev-perl/MIME-Base64-2.12
        >=dev-perl/URI-1.10
	>=dev-perl/HTML-Parser-3.15
	>=dev-perl/Digest-MD5-2.12
	>=dev-perl/libnet-1.0703-r1
	>=dev-perl/libwww-perl-5.50
	>=media-libs/libcdaudio-0.99.6"  

P=Audio-CD-0.04-disc-cover-1.1.0
SRC_URI="http://www.liacs.nl/~jvhemert/disc-cover/download/libraries/${P}.tar.gz"

inherit perl-module
