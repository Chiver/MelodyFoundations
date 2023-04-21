document.addEventListener('DOMContentLoaded', () => {
    // Replace with the actual data
    const nfts = [
      {
        image: '/images/img1.jpg',
        name: 'NFT 1',
        price: '0.5 ETH',
        owner: '0xabcdef...',
      },
      {
        image: '/images/img1.jpg',
        name: 'NFT 2',
        price: '1 ETH',
        owner: '0xaxxxxxx...',
      },
      // Add more NFT instances
    ];
  
    // Add the NFT instances to the nft-container
    const nftContainer = document.querySelector('.nft-container');
  
    nfts.forEach((nft) => {
      const nftItem = document.createElement('div');
      nftItem.classList.add('nft-item');
  
      const nftImage = document.createElement('img');
      nftImage.src = nft.image;
      nftImage.alt = nft.name;
      nftImage.classList.add('nft-image');
  
      const nftName = document.createElement('h3');
      nftName.textContent = nft.name;
      nftName.classList.add('nft-name');
  
      const nftPrice = document.createElement('p');
      nftPrice.textContent = nft.price;
      nftPrice.classList.add('nft-price');
  
      const nftOwner = document.createElement('p');
      nftOwner.textContent = nft.owner;
      nftOwner.classList.add('nft-owner');
  
      const buyBtn = document.createElement('button');
      buyBtn.textContent = 'Buy';
      buyBtn.classList.add('buy-btn');
      buyBtn.addEventListener('click', () => {
        // Add logic to navigate to the detail page of the NFT
      });
  
      nftItem.append(nftImage, nftName, nftPrice, nftOwner, buyBtn);
      nftContainer.appendChild(nftItem);
    });
  });
  