# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-pear/horde-pear-1.3-r3.ebuild,v 1.2 2005/03/09 06:50:42 sebastian Exp $

DESCRIPTION="Meta package for the PEAR packages required by Horde."
HOMEPAGE="http://pear.php.net/"

LICENSE="as-is"
SLOT="1"
# when unmasking for an arch
# double check none of the deps are still masked!
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE=""

S=${WORKDIR}

RDEPEND="dev-php/PEAR-Archive_Tar
	dev-php/PEAR-Auth_SASL
	dev-php/PEAR-Cache
	dev-php/PEAR-Console_Getopt
	dev-php/PEAR-Crypt_RC4
	dev-php/PEAR-Date
	dev-php/PEAR-DB
	dev-php/PEAR-File
	dev-php/PEAR-File_Find
	dev-php/PEAR-HTML_Common
	dev-php/PEAR-HTTP
	dev-php/PEAR-HTTP_Request
	dev-php/PEAR-HTTP_WebDAV_Server
	dev-php/PEAR-Log
	dev-php/PEAR-Mail
	dev-php/PEAR-Mail_Mime
	dev-php/PEAR-Net_DIME
	dev-php/PEAR-Net_DNS
	dev-php/PEAR-Net_Sieve
	dev-php/PEAR-Net_SMTP
	dev-php/PEAR-Net_Socket
	dev-php/PEAR-Net_URL
	dev-php/PEAR-PEAR
	dev-php/PEAR-Services_Weather
	dev-php/PEAR-SOAP
	dev-php/PEAR-Text_Wiki
	dev-php/PEAR-Tree
	dev-php/PEAR-XML_Parser
	dev-php/PEAR-XML_RPC
	dev-php/PEAR-XML_Serializer
	dev-php/PEAR-XML_Util"
