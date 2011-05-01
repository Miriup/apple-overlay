# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION=""
HOMEPAGE=""
SRC_URI="http://opensource.apple.com/tarballs/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="virtual/pmake"
RDEPEND="${DEPEND}"

src_unpack() {
	default
	cp ${FILESDIR}/commands-LINUX.make ${S}
}

src_compile() {
	pmake ARCH=x86_64-linux-gnu MAKEFILEDIR=${S} OS=LINUX PLATFORM_OS=linux \
		SILENT= || die pmake aborted.
}

src_install() {
	pmake ARCH=$(tc-arch)
}
